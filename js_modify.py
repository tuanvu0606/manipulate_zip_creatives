#!/usr/bin/env python3
import sys

changed_color = sys.argv[1]

with open('script.js') as fin, open('newprefs.js', 'w') as fout:
    for line in fin:
        if """change_color.innerHTML= change_color.innerHTML.replace(decodeURI("C%C3%92N"), "<span style='color:black;'>"+decodeURI("C%C3%92N")+"</span>");""" in line:
            line = """change_color.innerHTML= change_color.innerHTML.replace(decodeURI("C%C3%92N"), "<span style='color:""" + str(sys.argv[1]) + """;'>"+decodeURI("C%C3%92N")+"</span>");\n"""
        #fout.write(line)                
        if """change_color.innerHTML= change_color.innerHTML.replace(decodeURI("%C4%90%E1%BA%BEN"), "<span style='color:black;'>"+decodeURI("%C4%90%E1%BA%BEN")+"</span>");""" in line:
            line = """change_color.innerHTML= change_color.innerHTML.replace(decodeURI("%C4%90%E1%BA%BEN"), "<span style='color:""" + str(sys.argv[1]) + """;'>"+decodeURI("%C4%90%E1%BA%BEN")+"</span>");\n"""
        fout.write(line)                
#print sys.argv[1]