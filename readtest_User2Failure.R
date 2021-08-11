fileConn<-file("/test_mosaic/G1/newtest.txt")
readLines("/test_mosaic/G3/newtest.txt", fileConn)
close(fileConn)