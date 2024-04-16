#!/bin/sh

# Answer to the question 1: Counts the number of flights 
# that were delayed 15 minutes or more into or out of 
# Gainesville, FL (airport code GNV) during the time frame 
# covered by the dataset. (*2 points*)

cat flights.1k.csv | grep GNV | awk -F, '{if ($15 > 15 || $16 > 15) print $0}' | wc -l

# Answer to the question 2: Produce a table (text is fine) with
# the data to fill in this table (13 points, see rubric below for details):
# GNV to:	Total flights	Total flights delayed (≥15min)	Total flights delayed due to Weather
# ATL			
# CLT			
# MIA			

for dest in ATL CLT MIA
do
    total_flights=$(cat flights.1k.csv | grep GNV | grep $dest | wc -l)
    total_flights_delayed=$(cat flights.1k.csv | grep GNV | grep $dest | awk -F, '{if ($15 > 15 || $16 > 15) print $0}' | wc -l)
    total_flights_delayed_weather=$(cat flights.1k.csv | grep GNV | grep $dest | awk -F, '{if ($24 == "1") print $0}' | wc -l)
    echo "$dest: $total_flights $total_flights_delayed $total_flights_delayed_weather"
done

# Answer to the question 3: Within a function, print a list of all unique airport codes contained in the dataset. 

unique_airport_codes() {
    cat flights.1k.csv | awk -F, '{print $5}' | sort | uniq
}

# Answer to the question 4: Within a function list the cities in Florida that have airports in the dataset.

florida_cities() {
    cat flights.1k.csv | awk -F, '{if ($4 == "FL") print $3}' | sort | uniq
}

