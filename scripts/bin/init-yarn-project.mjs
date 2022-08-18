#!/usr/bin/env zx

const isMonorepoProject = argv.monorepo;
const useNodeModulesLinker = argv["node-modules"];

const stringify = (thing) => JSON.stringify(thing, null, 4);

// ===========================================
// YARN INIT AND SETTINGS
// ===========================================

if (isMonorepoProject) {
  await $`yarn init -2 -w`;
  await $`yarn plugin import workspace-tools`;
  await $`mkdir packages`;
} else {
  await $`yarn init -2`;
  await $`mkdir src`;
  await $`touch src/index.ts`;
}

if (useNodeModulesLinker) {
  const yarnrc = YAML.parse(await fs.readFile(".yarnrc.yml"));
  yarnrc.nodeLinker = "node-modules";
  await fs.writeFile(".yarnrc.yml", YAML.stringify(yarnrc));
}

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

// ===========================================
// SCRIPTS AND HUSKY SETTINGS
// ===========================================

const packageJson = await fs.readJson("package.json");
if (isMonorepoProject) {
  packageJson.workspaces = ["packages/*"];
  packageJson.scripts = {
    w: "yarn workspace",
    "w:each": `yarn workspaces foreach -vipt --exclude '${packageJson.name}' run`,
    "test:pre-commit": "yarn w:each test --bail --findRelatedTests",
  };
} else {
  packageJson.scripts = {
    build: "tsc",
    watch: "tsc --watch",
    test: "jest",
    "test:pre-commit": "yarn test --bail --findRelatedTests",
  };
}

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

// ===========================================
// CONFIG FILES
// ===========================================

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
    "!.yarn/cache",
  ],
};

if (useNodeModulesLinker) {
  gitIgnoreEntries.YARN.push("node_modules");
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

const prettierIgnore = [
  "dist",
  "build",
  "coverage",
  "node_modules",
  "**/.yarn",
  "**/.pnp.*",
];
await fs.writeFile(".prettierignore", prettierIgnore.join("\n"));
