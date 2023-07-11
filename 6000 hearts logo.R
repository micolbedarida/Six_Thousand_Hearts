library(magick)
library(OpenImageR)

img = image_read("G:/My Drive/SACH/High res stencil.jpg")
img = as.numeric(img[[1]])
img = img[,,1]

image(img)

n_zeros = length(img[img == 0])
print(n_zeros)

targetPixels = 6238

for (i in seq(3.0,10,0.00001)){
  
  img2 = down_sample_image(img, i)
  n_zeros2 = length(img2[img2 == 0])
  print(n_zeros2)
  
  if (n_zeros2 == targetPixels){
    break
  } 
  
}

# Rotate image
rotate <- function(x) t(apply(x, 2, rev))
img2 = rotate(img2)

# Extract matrix coordinates of 0's
coords = as.data.frame(which(img2 == 0, arr.ind=TRUE))
names(coords) = c("PixelX", "PixelY")

write.csv(coords,"Pixels4.csv", row.names = FALSE)
