If you're using the built-in LSP support you may have to do a bit of
troubleshooting. It may not always be easy to tell if the issue is coming from
missing LSP support or misconfiguration between Metals and Nvim. Here are a
couple pointers on tracking down the issue.

* Use `:MetalsLogsToggle` which will open the embedded Nvim terminal tailing the `.metals/metals.log` file. Take a look in there for something odd. More than likely if something isn't working, it will have blown up and you'll see a hint here.
* If you see an error flash in your terminal and you want to see what it was, `:messages` is your friend to find it.
* Read through the [Known Limitation](https://github.com/scalameta/nvim-metals/wiki/Known-limitations) again to make sure it's not something that is documented as not working.
* If you really want to get deep into debugging, create a [JSON-RPC trace file](https://scalameta.org/metals/docs/contributors/getting-started.html#json-rpc-trace) and then you can `tail` the communication between the Nvim LSP client the Metals server.
- When in doubt, just submit and issue, and we'll dive in together.
