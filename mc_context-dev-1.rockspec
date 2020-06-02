package = "mc_context"
version = "dev-1"
source = {
   url = "git+https://github.com/andrewstarks/mc_context.git"
}
description = {
   homepage = "https://github.com/andrewstarks/mc_context",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      ["mc_context.init"] = "mc_context/init.lua",
      ["test.mc_context"] = "test/mc_context.lua"
   }
}
