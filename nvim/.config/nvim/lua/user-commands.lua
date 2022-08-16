local createCommand = require("utils.create-command")

-- save current buffer as sudo (suda plugin)
createCommand("WS", ":w suda://%")
