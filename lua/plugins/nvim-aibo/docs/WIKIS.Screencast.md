# Toggle Aibo console window with `-toggle` option

https://github.com/user-attachments/assets/c3c4d0f3-7f62-468a-8c7c-122ab05b07e0

1. Open Claude Code with `Aibo -opener=vsplit -toggle claude`
2. Close Aibo console window with the same command
3. Reopen Aibo console window with the same command
4. Claude Code is working on background

# Order Ollama with Japanese prompt by [skkeleton]

https://github.com/user-attachments/assets/cd81b4fe-88a1-49be-8398-3fa2b4131ad2

1. Open Ollama with `Aibo ollama run gpt-oss:latest`
2. Write Japanese prompt by [skkeleton]

[skkeleton]: https://github.com/vim-skk/skkeleton

# Translate LICENSE through Claude Code

https://github.com/user-attachments/assets/73cf37d2-a676-42c5-8b0d-d2ad4808a377

1. Open Claude Code with `Aibo -stay -opener=vsplit claude`
2. Send entire buffer content with `AiboSend -prefix="Translate it in Japanese\n\n" -submit`
3. Hit `<Enter>` to submit (this was required because Claude Code thought the content was Paste Item)

# As a REPL of Deno

https://github.com/user-attachments/assets/596167ad-2f97-4130-91b4-331ebb2e41f6

1. Open Deno with `Aibo -stay -opener=vsplit deno`
2. Send selected buffer content with `AiboSend -submit -input`
3. Write `fib(10)` and submit with `<C-Enter>` (or `<F5>`)
