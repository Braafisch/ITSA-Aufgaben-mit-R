vehicle = read.table("./SampleDatasets/vehicle_overland.csv", header = TRUE, sep = ";")
speed_v = ts(vehicle["speed"])
plot(speed_v)
index = which.max(speed_v)
speed_v[index] = speed_v[index-1]
plot(speed_v)
mean(speed_v)
min(speed_v)
max(speed_v)
