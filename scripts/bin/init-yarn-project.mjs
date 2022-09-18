#!/usr/bin/env zx

const isMonorepoProject = argv.monorepo;
const showHelp = argv.help;
const useNodeModulesLinker = argv["node-modules"];
const isMinimal = argv["minimal"];

const stringify = (thing) => JSON.stringify(thing, null, 4);

if (showHelp){
    console.log("Options:")
    console.log("--monorepo: Initialize project as a monorepo")
    console.log("--node-modules: Use node-modules as nodeLinker")
    console.log("--minimal: create only minimal setup instead of full project")
    process.exit(0)
}


// ===========================================
// YARN INIT AND SETTINGS
// ===========================================

if (isMonorepoProject) {
  await $`yarn init -2 -w`;
  await $`yarn plugin import workspace-tools`;
} else {
  await $`yarn init -2`;
  await $`mkdir src`;
  if (!isMinimal) {
    await $`touch src/index.ts`;
  } else {
    await $`touch src/index.mjs`;
  }
}

if (useNodeModulesLinker) {
  const yarnrc = YAML.parse(await fs.readFile(".yarnrc.yml", "utf-8"));
  yarnrc.nodeLinker = "node-modules";
  await fs.writeFile(".yarnrc.yml", YAML.stringify(yarnrc));
}

if (!isMinimal) {
  await $`yarn plugin import interactive-tools`;
  await $`yarn plugin import typescript`;

  // ===========================================
  // DEPENDENCIES
  // ===========================================

  const initialPackages = [
    "@types/eslint",
    "@types/jest",
    "@types/prettier",
    "@typescript-eslint/eslint-plugin",
    "@typescript-eslint/parser",
    "eslint",
    "eslint-config-airbnb-base",
    "eslint-config-prettier",
    "eslint-import-resolver-node",
    "eslint-plugin-import",
    "eslint-plugin-jest",
    "husky",
    "jest",
    "lint-staged",
    "prettier",
    "ts-jest",
    "typescript",
  ];

  await $`yarn add -D ${initialPackages}`;
}

// ===========================================
// SCRIPTS AND HUSKY SETTINGS
// ===========================================

const packageJson = await fs.readJson("package.json");
if (isMonorepoProject) {
  packageJson.scripts = {
    w: "yarn workspace",
    "w:each": `yarn workspaces foreach -vipt --exclude '${packageJson.name}' run`,
    "test:pre-commit":
      "yarn w:each test --bail --findRelatedTests --passWithNoTests",
  };
} else {
  if (!isMinimal) {
    packageJson.scripts = {
      build: "tsc",
      watch: "tsc --watch",
      test: "jest",
      "test:pre-commit":
        "yarn test --bail --findRelatedTests --passWithNoTests",
    };
  }
}

if (!isMinimal) {
  Object.assign(packageJson.scripts, {
    "pre-commit": "lint-staged",
    postinstall: "husky install",
  });

  if (!isMonorepoProject) {
    await $`yarn add -D pinst`;
    Object.assign(packageJson.scripts, {
      prepack: "pinst --disable",
      postpack: "pinst --enable",
    });
  }

  packageJson["lint-staged"] = {
    "*": "prettier --ignore-unknown --write",
    "*.ts": ["eslint --cache --fix", "yarn test:pre-commit"],
  };
  await fs.writeFile("package.json", stringify(packageJson));

  await $`yarn husky install`;
  await $`yarn husky add .husky/pre-commit "yarn pre-commit"`;
}

// ===========================================
// CONFIG FILES
// ===========================================
if (!isMinimal) {
  await $`yarn tsc --init`;
  await $`yarn ts-jest config:init`;

  await fs.writeFile(
    ".eslintrc.json",
    stringify({
      root: true,
      parser: "@typescript-eslint/parser",
      env: {
        browser: true,
        es2021: true,
        node: true,
        "jest/globals": true,
      },
      plugins: ["@typescript-eslint", "import", "jest"],
      extends: [
        "eslint:recommended",
        "plugin:@typescript-eslint/recommended",
        "plugin:import/recommended",
        "plugin:import/typescript",
        "plugin:jest/recommended",
        "prettier",
      ],
      ignorePatterns: ["**/dist/**", "**/*.js"],
      rules: {
        "no-warning-comments": [
          "error",
          {
            terms: ["todo", "fixme", "fix", "refactor"],
          },
        ],
        camelcase: "error",
      },
    })
  );
}

const gitIgnoreEntries = {
  BUILDS: ["dist"],
  JEST: ["coverage"],
  ESLINT: [".eslintcache"],
  ENVIRONMENTS: [".env", "!.env.example"],
  YARN: [
    ".yarn/*",
    "!.yarn/patches",
    "!.yarn/plugins",
    "!.yarn/releases",
    "!.yarn/sdks",
    "!.yarn/versions",
    "node_modules",
  ],
};

if (isMinimal) {
  gitIgnoreEntries.YARN.push(".pnp.*");
} else {
  gitIgnoreEntries.YARN.push("!.yarn/cache");
}

await fs.writeFile(
  ".gitignore",
  Object.keys(gitIgnoreEntries).reduce((result, key) => {
    return (result += `#===========================
# ${key}
#===========================
${gitIgnoreEntries[key].join("\n")}

`);
  }, "")
);

await fs.writeFile(
  ".prettierrc",
  stringify({
    tabWidth: 4,
    printWidth: 72,
    htmlWhitespaceSensitivity: "ignore",
  })
);

if (!isMinimal) {
  const prettierIgnore = [
    "dist",
    "build",
    "coverage",
    "node_modules",
    "**/.yarn",
    "**/.pnp.*",
  ];
  await fs.writeFile(".prettierignore", prettierIgnore.join("\n"));
}

await $`git add . && git commit -m "Initial commit"`;
