---
## :no_entry: Mason failed to install jdtls -> `Cannot find package "xxxxx"`

<details>

<summary>Solution</summary>

`nvim-java` is using specific versions for some packages such as `jdtls` that's different from the main Mason.nvim registry. Reason for that is to avoid breakage due to package update. For this, `nvim-java` has a custom mason-registry [here](https://github.com/nvim-java/mason-registry) containing those packages. `nvim-java` passes that custom registry in the lazy configuration using [lazy.lua](https://github.com/nvim-java/nvim-java/blob/main/lazy.lua) however, this might not be passed to the `require('mason').setup()` function if you skips passing the default options. 

So, this issue probably occurs due to the way you have configured Mason.nvim. Follow the instructions below to correctly configure Mason.nvim using Lazy.nvim.

### Method 1: use `opts` instead of `config` function to setup mason

```lua
return {
	'williamboman/mason.nvim',
	opts = {
		ui = {
			icons = {
				package_installed = '✓',
				package_pending = '➜',
				package_uninstalled = '✗',
			},
		},
	},
	-- use OPTS property to pass the configuration
	-- lazy vim call the setup function for you

	-- config = function()
	-- 	require('mason').setup({})
	-- end
	-- ^^^^^^^^^^^^^^^^ DON'T DO THIS
}

```

### Method 2: If you have complex configuration inside `config`, you can pass a function to `opts`

```lua
return {
	'williamboman/mason.nvim',
	opts = function()
		-- do all your complex stuff here

		return {
			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		}
	end,
}
```

### Method 3: If you really want to use `config` property for some reason, consider the default values

```lua
return {
	'williamboman/mason.nvim',
	config = function(_, opts)
		local conf = vim.tbl_deep_extend('keep', opts, {
			ui = {
				icons = {
					package_installed = '✓',
					package_pending = '➜',
					package_uninstalled = '✗',
				},
			},
		})
		-- ^^^^^ Here we are basically merge you configuration with OPTS
		-- OPTS contains configurations defined elsewhere like nvim-java

		require('mason').setup(conf)
	end,
}
```

</details>

---
## :no_entry: How to clean rebuild

<details>

<summary>Solution</summary>

Unfortunately, we don't have command to auto update the classpath when you change dependencies, or jdk. Without force rebuild, changes will not be applied. So for now, you can manually remove following files.

**In the project**, remove,

- `.classpath`
- `.project`

**In cache**, remove,

- `$HOME/.cache/jdtls`
- `$HOME/.cache/nvim/jdtls`

</details>

---
## :no_entry: LSP doesn't work on Maven projects

<details>

<summary>Solution</summary>

- Go to the project and run

```shell
mvn eclipse:clean eclipse:eclipse
```
- Now open the project in Neovim

Read [this](https://docs.geotools.org/latest/userguide/build/maven/eclipse.html) article for more information

</details>

---
## :no_entry: `To enrich the config, XXX should already be present`

<details>

<summary>Solution</summary>

If you are getting this error, that means `jdtls` having a hard time finding the root of the project.
This mostly happens when one of the parent directories is a `git` repository. If you are someone who
manages the dotfiles in the `$HOME` directory using a git repository, you might see this error.

- As a solution, you can make the current project root a git repository by running `git init`
- Another option would be to pass the root markers when setting up `nvim-java` but not pass `.git`

```lua
require('java').setup({
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'mvnw',
    'gradlew',
    'build.gradle',
    'build.gradle.kts'
  },
})
```

- Make current folder a git repository

```shell
git init
```
- Re-open neovim

</details>

---
## :no_entry: How to remove noisy and annoying `jdtls` notifications

<details>

<summary>Solution</summary>

If you find following notifications annoying, first of all, this has nothing to do with this plugin,
BUT you can simply remove them when you are setting up the language server. 

![image](https://github.com/nvim-java/nvim-java/assets/18459807/4dd4b20a-020d-463e-bcc5-85989affb469)


Here is how you can do it.

```lua
require("lspconfig").jdtls.setup({
	handlers = {
		-- By assigning an empty function, you can remove the notifications
		-- printed to the cmd
		["$/progress"] = function(_, result, ctx) end,
	},
})
```

</details>

---
## :no_entry: Disable OpenJDK-17 auto installation

<details>

<summary>Solution</summary>

We are installing `jdk-17` because that's the recommended runtime to run `jdtls`. However, if you have `jdk-17` already, you can use that instead. To disable auto install, set `jdk.auto_install` to `false`

```lua
require('java').setup({
  jdk = {
    auto_install = false,
  },
})
```
 
</details>

---
## :no_entry: `Unknown purl type: openvsx`

<details>

<summary>Solution</summary>

This is not related to `nvim-java` but you can solve it by updating `mason.nvim` plugin.

Case of this error is, mason-registry recently added packages from openvsx registry. However, old mason.nvim plugin does not know how to process this registry type.

</details>