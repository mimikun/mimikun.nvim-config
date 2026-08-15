‌‌‌‌In many cases, it is difficult for me to reproduce a bug. In such situations, you can help me identify the bug through these steps:

1. Enable avante.nvim's debug mode: `<leader>ad`
2. Reproduce the bug, then enter `:messages` to find the path of the last `*-request-body.json` file and `*-response-body.txt` file
3. `cat <the path of *-request-body.json> | jq -r ".messages"` or `cat <the path of *-request.body.json> | jq -r ".contents"`
4. Send me the request body content from above
5. `cat <the path of *response-body.txt>`
6. Send me the response body content from above

You need to provide the two files above: request-body.json and response-body.txt