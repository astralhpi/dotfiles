local iron = require('iron')

iron.core.add_repl_definitions {
  python = {
  }
}

iron.core.set_config {
  preferred = {
    python = "ipython",
  }
}
