#!/bin/bash
source config.cfg

# If psql is not available, then exit
if ! command -v psql > /dev/null ; then
  echo "This script requires psql to be installed and on your PATH. Exiting"
  exit 1
fi

psql postrgres
/c chinook
counter=2009
while [ $counter -le 2013 ]
do
touch invoices_$counter.csv
"SELECT invoices.InvoiceId, customers.FirstName, customers.LastName, customers.Company,  invoices.InvoiceDate,tracks.TrackId, artists.name, albums.Title, tracks.Name,
FROM invoices, tracks
JOIN customers ON invoices.CustomerId = customers.CustomerId
JOIN albums ON albums.AlbumId = tracks.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
WHERE invoices.InvoiceDate >= '$counter-01-01 00:00:00' 
 AND  invoices.InvoiceDate <  '$counter-01-01 00:00:00" >> invoices_$counter.csv
((counter++))
done
