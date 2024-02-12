local M = {
	__pick_matrix = vmath.matrix4(),
	__world_to_screen_matrix = vmath.matrix4(),
	__viewport_rect,
	__screen_rect,
	__window_size,
	__window_listener_list = {},
	__logical_width = 1024, __logical_height = 672,
	__min_aspect_ratio = 4/3, __max_aspect_ratio = 16/9,
}

function M.get_viewport_rect()
	return unpack(M.__viewport_rect)
end

function M.get_screen_rect()
	return unpack(M.__screen_rect)
end

function M.screen_to_world(x, y)
	local p = M.__pick_matrix * vmath.vector4(x, y, 0, 1)
	return p.x, p.y
end

function M.world_to_screen(x, y)
	local p = M.__world_to_screen_matrix * vmath.vector4(x, y, 0, 1)
	return p.x, p.y
end

function M.add_window_listener(url)
	M.__window_listener_list[tostring(url)] = url
end

function M.remove_window_listener(url)
	M.__window_listener_list[tostring(url)] = nil
end

function M.__calc_matrix(proj, view, width, height)
	local n = vmath.matrix4()
	n.m00 = 2/width
	n.m03 = -1
	n.m11 = 2/height
	n.m13 = -1
	n.m22 = 2
	n.m23 = -1
	M.__pick_matrix = vmath.inv(proj * view) * n
	M.__world_to_screen_matrix = vmath.inv(M.__pick_matrix)
end

return M
