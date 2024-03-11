
local Utils = require('utils')

return Utils.concat_tables(
    require('plugins.private.whichkey'),
    require('plugins.private.brazil'),
    require('plugins.private.brazil-config'),
    require('plugins.private.crux'),
    require('plugins.private.paste')
)
