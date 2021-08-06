fileConn<-file("/test_mosaic/G1/write.txt")
readLines(("/test_mosaic/G1/write.txt"), fileConn)
close(fileConn)