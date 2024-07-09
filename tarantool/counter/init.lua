box.cfg {listen = "0.0.0.0:3301"}
box.schema.user.grant("guest", "read,write,execute,create,drop", "universe")
box.schema.space.create("test")
box.space.test:format({{name = "name", type = "string"}, {name = "value", type = "integer"}})
box.space.test:create_index("primary", {parts = {"name"}})
