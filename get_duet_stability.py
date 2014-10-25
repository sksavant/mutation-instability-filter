#!/usr/bin/python
from bs4 import BeautifulSoup as BS
import re, subprocess, sys, os

value_regex = re.compile ("\-?[0-9]*.?[0-9]* Kcal/mol")

def parseDuetOutput (mutation_name, protein_name):
  file_name = "Duet_"+mutation_name+"-"+protein_name+".html"
  try:
    soup = BS (open(file_name, 'r').read ())
  except IOError:
    print mutation_name, protein_name
    subprocess.call (['./get_duet_stability.sh', mutation_name, protein_name], shell=True, executable="/bin/bash")
    #os.system ('./get_duet_stability.sh'+mutation_name+' '+protein_name)
    soup = BS (open(file_name, 'r').read ())

  out = soup.find("div", {'class': 'well'})
  #print out.select ("div > font:nth-child(10) , font:nth-child(6) , font:nth-child(2)")
  stabilities = value_regex.findall (str(out))
  for val in stabilities:
    print val[:len(val)-9],

if __name__ == '__main__':
  try:
    mutation_name = sys.argv[1]
  except IndexError:
    mutation_name = "F134L"
  try:
    protein_name = sys.argv[2]
  except IndexError:
    protein_name = "2OCJ"
  parseDuetOutput (mutation_name, protein_name)
