" iptables syntax
if getline(1) =~ "^# Generated by iptables-save" ||  getline(1) =~ "^# Firewall configuration written by" 
  setfiletype iptables 
  set commentstring=#%s 
  finish 
endif
" sh detection
if getline(1) =~ "^#!/bin/bash" || getline(1) =~ "^#!/bin/sh"
    setfiletype sh
    set commentstring=#%s
    set makeprg=bash\ -n\ %
    finish
endif
