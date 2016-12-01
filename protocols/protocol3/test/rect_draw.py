# rect_draw.py
import cv2
im = 'random_01.png'
img = cv2.imread(im)

x1,y1,x2,y2 = 10,10,30,30
cv2.rectangle(img, (x1, y1), (x2, y2), (255,0,0), 2)

cv2.imshow('rect', img)
cv2.waitKey()
cv2.destroyAllWindows()