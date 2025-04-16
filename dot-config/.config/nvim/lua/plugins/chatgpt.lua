require("gp").setup({
	chat_user_prefix = ":",
	chat_template = require("gp.defaults").short_chat_template,
	providers = {
 		deepseek = {
			endpoint = "https://api.deepseek.com/v1/chat/completions",
			secret = { "cat", "/home/jorres/deepseek_api_key" },
		},
 		openai = {
			endpoint = "https://api.openai.com/v1/chat/completions",
			secret = { "cat", "/home/jorres/openai_api_key" },
		},
	},
	-- agents = {
	-- 	{
	-- 		name = "deepseek-r1",
	-- 		provider = "deepseek",
	-- 		chat = true,
	-- 		command = true,
	-- 		model = { model = "deepseek-reasoner" },
	-- 		system_prompt = "You are a general very capable AI assistant.\n\n",
 --      endpoint = "https://api.deepseek.com/v1/chat/completions",
	-- 	},
	-- 	{
	-- 		name = "deepseek-chat",
	-- 		chat = true,
	-- 		command = true,
	-- 		provider = "deepseek",
	-- 		model = { model = "deepseek-chat" },
	-- 		system_prompt = "You are a general very capable AI assistant.\n\n"
	-- 				.. "You are required to respond in the following way:\n\n"
	-- 				.. "- If you're unsure don't guess and say you don't know instead.\n"
	-- 				.. "- Ask questions if you need clarification to provide better answer.\n"
	-- 				.. "- Don't elide any code from your output if the answer requires coding.\n"
	-- 				.. "- Try to give your reply succintly. No need to paraphrase what you have already said.\n"
	-- 				.. "- Assume the user is educated and smart, no need to explain minute details.\n"
	-- 				.. "- For questions that can be answered with a single sentence or single example, you must do so without writing several hundred words"
	-- 				.. "- Try to keep your explanations as short as possible. Whenever a question requires a simple reply, you must not additionally explain every step."
	-- 				.. "- Take a deep breath; You've got this!\n",
 --      endpoint = "https://api.deepseek.com/v1/chat/completions",
	-- 	},
	-- 	{
	-- 		name = "o1-mini",
	-- 		disable = true,
	-- 	},
	-- 	{
	-- 		name = "o1-preview",
	-- 		disable = true,
	-- 	},
	-- 	{
	-- 		name = "ChatGPT4o",
	-- 		disable = true,
	-- 	},
	-- 	{
	-- 		name = "ChatGPT4o-mini",
	-- 		disable = true,
	-- 	},
	-- },
	agents = {
		{
			name = "ChatGPT4o",
			disable = true,
		},
		{
			name = "ChatGPT4o-mini",
			disable = true,
		},
		{
			name = "ChatGPT-o3-mini",
			disable = true,
		},
		{
			name = "o4-mini-high",
			provider = "openai",
			chat = true,
			command = false,
			model = { model = "o4-mini", reasoning_effort = "high" },
			system_prompt = "You are a general very capable AI assistant.\n\n",
		},
		{
			name = "gpt-4.1",
			chat = true,
			command = true,
			provider = "openai",
			model = { model = "gpt-4.1", temperature = 0.8, top_p = 1 },
			system_prompt = "You are a general very capable AI assistant.\n\n"
					.. "You are required to respond in the following way:\n\n"
					.. "- If you're unsure don't guess and say you don't know instead.\n"
					.. "- Ask questions if you need clarification to provide better answer.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Try to give your reply succintly. No need to paraphrase what you have already said.\n"
					.. "- Assume the user is educated and smart, no need to explain minute details.\n"
					.. "- For questions that can be answered with a single sentence or single example, you must do so without writing several hundred words"
					.. "- Try to keep your explanations as short as possible. Whenever a question requires a simple reply, you must not additionally explain every step."
					.. "- Take a deep breath; You've got this!\n",
		},
	},
})
