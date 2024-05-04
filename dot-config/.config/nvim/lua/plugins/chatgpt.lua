require("gp").setup({
	openai_api_key = { "cat", "/home/jorres/openai_api_key" },
	chat_user_prefix = ":",
	agents = {
		{
			name = "ChatGPT4",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4-turbo", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are a general AI assistant.\n\n"
					.. "You are required to respond in the following way:\n\n"
					.. "- If you're unsure don't guess and say you don't know instead.\n"
					.. "- Ask question if you need clarification to provide better answer.\n"
					.. "- Think deeply and carefully from first principles step by step.\n"
					.. "- Zoom out first to see the big picture and then zoom in to details.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Try to give your reply succintly. No need to paraphrase what you have already said.\n"
					.. "- Assume the user is educated and smart, no need to explain minute details.\n"
					.. "- Take a deep breath; You've got this!\n",
		},
		{ name = "ChatGPT3.5", },
		{ name = "CodeGPT3-5", },
	},
})
