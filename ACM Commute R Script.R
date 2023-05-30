#Script to calculate commute times using Google's Distance Matrix API and the gmapsdistance package
#API documentation at (https://developers.google.com/maps/documentation/distance-matrix/overview)
#package documentation at (https://cran.r-project.org/web/packages/gmapsdistance/readme/README.html)

#Establish package library and load API key
library(gmapsdistance)  
gmapsdistance::set.api.key('INSERT YOUR API KEY HERE')

#Create Address Lists 
#Notes:The API has a limit of 25 origins or destinations so lists must be 25 addresses or shorter. Address lists should be grouped by ACMs selected transportation option.
ACM_Addresses1<-c("ACM+ADDRESS+1","ACM+ADDRESS+2")
ACM_Addresses2<-c("ACM+ADDRESS+3","ACM+ADDRESS+4")
School_Addresses<-c("SCHOOL+ADDRESS+1","SCHOOL+ADDRESS+2,")

#Calculate commute matrix for each ACM address list and each School address list
#Notes: Ensure that the mode matches the ACMs selected form of transportation. Transit matrices should include a arrival time set with the arr_time variable. Driving matrices should include a departure time of 7am and traffic_model set to "best_guess".
T_commutes1<- gmapsdistance(origin = ACM_Addresses1, 
              destination = School_Addresses, 
              combinations = "all",
              mode = "transit",
              arr_date = "2023-08-28",
              arr_time = "13:45:00") 
T_commutes2<- gmapsdistance(origin = ACM_Addresses2, 
                          destination = School_Addresses, 
                          combinations = "all",
                          mode = "transit",
                          arr_date = "2023-08-28",
                          arr_time = "13:45:00") 
D_commutes1<- gmapsdistance(origin = ACM_Addresses1, 
                         destination = School_Addresses, 
                         combinations = "all",
                         mode = "driving",
                         dep_date = "2023-08-28",
                         dep_time = "13:00:00",
                         traffic_model = "best_guess") 

#Use rbind to merge all the resulting matrices into a single matrix
ACM_Commute_Matrix<- rbind(T_commutes1$Time,T_commutes2$Time,D_commutes1$Time)

#write final matrix to csv
#Note: Time is calculated in seconds
write.csv(ACM_Commute_Matrix,"C:/YOUR FILE PATH HERE/acm_commute_matrix.csv")
