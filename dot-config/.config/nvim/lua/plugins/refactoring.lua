require('refactoring').setup({
  -- overriding printf statement for cpp
  print_var_statements = {
      -- add a custom printf statement for cpp
      cpp = {
          'std::cerr << "%s %%s" << std::endl;'
      },
  }
})
