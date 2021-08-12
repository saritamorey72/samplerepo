fileConn<-file("/test_mosaic/G1/writeG1.txt")
readLines(("/test_mosaic/G1/writeG1.txt"), fileConn)
close(fileConn)