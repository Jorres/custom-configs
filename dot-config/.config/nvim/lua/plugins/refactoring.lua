return {
    {
        'ThePrimeagen/refactoring.nvim',
        opts = {
            -- overriding printf statement for cpp
            print_var_statements = {
                cpp = {
                    'std::cerr << "%s %%s" << std::endl;'
                },
            }
        }
    }
}
