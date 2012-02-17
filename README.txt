lisp-bot is an irc bot.

It doesn't do very much right now.

To run lisp-bot:

1. Start your favorite Lisp implementation.
2. Make sure lisp-bot.asd is in your system path.
3. Load lisp-bot.asd
   - using Quicklisp: (ql:quickload :lisp-bot :verbose t)
4. Start the bot: (lisp-bot:start-bot nick server password channel1 channel2 ...)
   - All arguments are strings.
