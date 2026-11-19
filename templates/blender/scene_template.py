"""Blender scene template: run with blender -b --python scene_template.py -- --output frame.png"""
import bpy
import sys

argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
output = argv[argv.index("--output") + 1] if "--output" in argv else "/tmp/studio-test.png"

bpy.ops.wm.read_factory_settings(use_empty=True)
scene = bpy.context.scene
scene.render.engine = 'CYCLES'
scene.cycles.samples = 16
scene.render.resolution_x = 640
scene.render.resolution_y = 360
scene.render.resolution_percentage = 100
scene.render.image_settings.file_format = 'PNG'
scene.render.filepath = output
scene.view_settings.view_transform = 'AgX'

bpy.ops.mesh.primitive_cube_add(location=(0, 0, 0))
bpy.ops.mesh.primitive_plane_add(size=10, location=(0, 0, -1.1))
light_data = bpy.data.lights.new('Key', 'AREA')
light_data.energy = 800
light = bpy.data.objects.new('Key', light_data)
scene.collection.objects.link(light)
light.location = (3, -4, 5)
light.rotation_euler = (0.7, 0, 0.6)

camera_data = bpy.data.cameras.new('Camera')
camera = bpy.data.objects.new('Camera', camera_data)
scene.collection.objects.link(camera)
camera.location = (5, -6, 4)
camera.rotation_euler = (0.9, 0, 0.7)
scene.camera = camera

bpy.ops.render.render(write_still=True)
print(f"studio-template-render={output}")
