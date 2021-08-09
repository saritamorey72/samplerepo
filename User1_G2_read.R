fileConn<-file("/test_mosaic/G2/write.txt")
readLines(("/test_mosaic/G2/write.txt"), fileConn)
print(fileConn)
close(fileConn)

print(“any string”)