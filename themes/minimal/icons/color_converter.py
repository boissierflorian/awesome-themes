from PIL import Image
import sys

def rgb_to_hex(rgb):
	return '%02x%02x%02x%02x' % rgb 

def main():
	print("Pixel Converter")
	argc = len(sys.argv)
	if argc != 2:
		print("Invalid arguments")
		sys.exit(-1)
	
	img_path = sys.argv[1]
	base_color = "85acfb"
	new_color = "3e646f"

	im = Image.open(img_path)

	im_data = {}
	im_data["mode"] = im.mode
	im_data["size"] = im.size
	print(im_data)


	pixels = im.load()
	width, height = im.size

	newim = Image.new('RGBA', im.size)
	newim_data = []

	print(width, height)
	for origin_rgb in im.getdata():
		print(origin_rgb)
		origin_hex = rgb_to_hex(origin_rgb)
		if origin_hex == base_color:
			newim_data.append((24, 39, 43))
		else:
			newim_data.append(origin_rgb)
	
	newim.putdata(newim_data)
	newim.save("test.png")


if __name__ == "__main__":
	main()
