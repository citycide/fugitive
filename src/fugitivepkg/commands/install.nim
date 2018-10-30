include ../base

from ./alias import createAlias

const
  helpMessage = """
  This will alias various fugitive commands as git subcommands,
  which means for example that these would be equivalent:

    git unstage <...files>
    fugitive unstage <...files>

  Be aware this can conflict with other tools that may do the same.
  Nothing will be overridden unless you pass the --override (-o) flag.
  """.strip
  usageMessage = &"""
  Usage: fugitive install [--override|-o] [--force|-y]

  {helpMessage}

  If you're brave you can pass the --force (-y) flag to skip the
  confirmation prompt.
  """

  commandsToAlias* = [
    "alias",
    "changelog",
    "lock",
    "mirror",
    "open",
    "release",
    "scrap",
    "summary",
    "undo",
    "unlock",
    "unstage"
  ]

proc install* (args: Arguments, opts: Options) =
  if getOptionValue(opts, "h", "help", bool):
    echo "\n" & usageMessage
    quit 0

  let noPrompt = getOptionValue(opts, "y", "force", bool)
  if not noPrompt and not prompt(helpMessage):
    print "Install cancelled."
    quit 0

  var shouldOverwrite = false
  if getOptionValue(opts, "o", "override", bool):
    if noPrompt:
      shouldOverwrite = true
      echo "  fugitive will override existing aliases."
    else:
      shouldOverwrite = prompt """
      This will override existing aliases, possibly from other tools.
      """.strip

  for command in commandsToAlias:
    let value = "!fugitive " & command
    let (existing, _) = execCmdEx "git config --global alias." & command
    let stripped = existing.strip
    if stripped == value:
      # this alias has already been set
      continue
    elif stripped != "" and not shouldOverwrite:
      # user hasn't allowed overriding existing aliases
      continue

    let (_, code) = createAlias(command, value)
    if code != 0:
      failSoft "Could not set alias for '" & command & "'"

  print "Aliases installed. Use `fugitive uninstall` to remove them."