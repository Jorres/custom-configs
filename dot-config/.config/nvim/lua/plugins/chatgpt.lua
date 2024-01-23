-- local config = {
--   yank_register = "+",
--   edit_with_instructions = {
--     diff = false,
--     keymaps = {
--       accept = {},
--       toggle_diff = {},
--       toggle_settings = "<C-o>",
--       cycle_windows = "<Tab>",
--       use_output_as_input = {},
--     },
--   },
--   chat = {
--     loading_text = "loading",
--     question_sign = "", -- you can use emoji if you want e.g. 🙂
--     answer_sign = "", -- 🤖
--     max_line_length = 60,
--     sessions_window = {
--       border = {
--         style = "solid",
--         text = {
--           top = "",
--         },
--       },
--       -- win_options = {
--       --   winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--       -- },
--     },
--     keymaps = {
--       close = {},
--       yank_last = {},
--       yank_last_code = {},
--       scroll_up = {},
--       scroll_down = {},
--       toggle_settings = "<C-o>",
--       new_session = "<C-n>",
--       cycle_windows = "<Tab>",
--       select_session = "<Space>",
--       rename_session = "r",
--       delete_session = "d",
--       submit = ";",
--     },
--   },
--   popup_layout = {
--     relative = "editor",
--     position = "50%",
--     size = {
--       height = "80%",
--       width = "80%",
--     },
--   },
--   popup_window = {
--     filetype = "chatgpt",
--     border = {
--       -- highlight = "FloatBorder",
--       style = "solid",
--       text = {
--         top = "",
--       },
--     },
--     -- win_options = {
--     --   winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--     -- },
--   },
--   popup_input = {
--     prompt = "  ",
--     border = {
--       highlight = "FloatBorder",
--       style = "solid",
--       text = {
--         top_align = "center",
--         top = "",
--       },
--     },
--     -- win_options = {
--     --   winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--     -- },
--     submit = ";",
--   },
--   settings_window = {
--     border = {
--       style = "solid",
--       text = {
--         top = "",
--       },
--     },
--     -- win_options = {
--     --   winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--     -- },
--   },
--   openai_params = {
--     model = "gpt-3.5-turbo",
--     frequency_penalty = 0,
--     presence_penalty = 0,
--     max_tokens = 300,
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
--   openai_edit_params = {
--     model = "code-davinci-edit-001",
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
--   actions_paths = {},
--   predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
-- }
--
-- require("chatgpt").setup(config)
local conf = {
	-- required openai api key
	openai_api_key = os.getenv("OPENAI_API_KEY"),
	-- api endpoint (you can change this to azure endpoint)
	openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
	-- openai_api_endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions?api-version=2023-03-15-preview",
	-- prefix for all commands
	cmd_prefix = "Gp",
	-- optional curl parameters (for proxy, etc.)
	-- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
	curl_params = {},

	-- directory for storing chat files
	chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
	-- chat model (string with model name or table with model name and parameters)
	chat_model = { model = "gpt-3.5-turbo-1106", temperature = 0.9 },
	-- chat model system prompt (use this to specify the persona/role of the AI)
	chat_system_prompt = "You are a general AI assistant.",
	-- chat custom instructions (not visible in the chat but prepended to model prompt)
	chat_custom_instructions = "The user provided the additional info about how they would like you to respond:\n\n"
		.. "- If you're unsure don't guess and say you don't know instead.\n"
		.. "- Ask question if you need clarification to provide better answer.\n"
		.. "- Think deeply and carefully from first principles step by step.\n"
		.. "- Don't elide any code from your output if the answer requires coding.\n"
		.. "- Don't overcomplicate explanations. Shorter answers usually suffice.\n"
		.. "- Take a deep breath; You've got this!\n",
	-- chat user prompt prefix
	chat_user_prefix = ":",
	-- chat assistant prompt prefix
	chat_assistant_prefix = "🤖:",
	-- chat topic generation prompt
	chat_topic_gen_prompt = "Summarize the topic of our conversation above"
		.. " in two or three words. Respond only with those words.",
	-- chat topic model (string with model name or table with model name and parameters)
	chat_topic_gen_model = "gpt-3.5-turbo-16k",
	-- explicitly confirm deletion of a chat file
	chat_confirm_delete = true,
	-- conceal model parameters in chat
	chat_conceal_model_params = true,
	-- local shortcuts bound to the chat buffer
	-- (be careful to choose something which will work across specified modes)
	chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
	chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
	chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>n" },

	-- command config and templates bellow are used by commands like GpRewrite, GpEnew, etc.
	-- command prompt prefix for asking user for input
	command_prompt_prefix = "🤖 ~ ",
	-- command model (string with model name or table with model name and parameters)
	command_model = { model = "gpt-3.5-turbo-16k", temperature = 1.1, top_p = 1 },
	-- command system prompt
	command_system_prompt = "You are an AI that strictly generates just the formated final code.",

	-- templates
	template_selection = "I have the following code from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
	template_rewrite = "I have the following code from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond just with the snippet of code that should be inserted.",
	template_append = "I have the following code from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond just with the snippet of code that should be appended after the code above.",
	template_prepend = "I have the following code from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond just with the snippet of code that should be prepended before the code above.",
	template_command = "{{command}}",

	-- https://platform.openai.com/docs/guides/speech-to-text/quickstart
	-- Whisper costs $0.006 / minute (rounded to the nearest second)
	-- by eliminating silence and speeding up the tempo of the recording
	-- we can reduce the cost by 50% or more and get the results faster
	-- directory for storing whisper files
	whisper_dir = "/tmp/gp_whisper",
	-- multiplier of RMS level dB for threshold used by sox to detect silence vs speech
	-- decibels are negative, the recording is normalized to -3dB =>
	-- increase this number to pick up more (weaker) sounds as possible speech
	-- decrease this number to pick up only louder sounds as possible speech
	-- you can disable silence trimming by setting this a very high number (like 1000.0)
	whisper_silence = "1.75",
	-- whisper max recording time (mm:ss)
	whisper_max_time = "05:00",
	-- whisper tempo (1.0 is normal speed)
	whisper_tempo = "1.75",

	-- example hook functions (see Extend functionality section in the README)
	hooks = {
		InspectPlugin = function(plugin, params)
			print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
			print(string.format("Command params:\n%s", vim.inspect(params)))
		end,

		-- GpImplement rewrites the provided selection/range based on comments in the code
		Implement = function(gp, params)
			local template = "Having following from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please rewrite this code according to the comment instructions."
				.. "\n\nRespond only with the snippet of finalized code:"

			gp.Prompt(
				params,
				gp.Target.rewrite,
				nil, -- command will run directly without any prompting for user input
				gp.config.command_model,
				template,
				gp.config.command_system_prompt
			)
		end,

		-- your own functions can go here, see README for more examples like
		-- :GpExplain, :GpUnitTests.., :GpBetterChatNew, ..

	},
}

require("gp").setup(conf)

local function keymapOptions(desc)
    return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = "GPT prompt " .. desc,
    }
end

vim.keymap.set({"n", "i"}, "<C-g>r", "<cmd>GpChatRespond<cr>", keymapOptions("Respond"))
vim.keymap.set({"n", "i"}, "<C-g>n", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
