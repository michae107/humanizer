extends Node
class_name HumanizerResourceService

static var resource_mutex: Mutex = null
static var exited = false

static func start():
    if resource_mutex == null:
        resource_mutex = Mutex.new()

static func exit():
    resource_mutex.lock()
    exited = true
    resource_mutex.unlock()
    HumanizerLogger.debug("resource service shutdown")

static func load_resource(path) -> Resource:
    if exited:
        assert(false, "This should not happen.")

    start()
    var resource: Resource
    resource_mutex.lock()
    resource = load(path)
    resource_mutex.unlock()
    return resource