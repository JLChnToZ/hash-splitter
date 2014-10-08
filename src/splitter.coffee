# Hash Splitter
# A simple function that splits any hex string into array of integer values you want.
# Copyright (C) 2014, Jeremy Lam (JLChnToZ)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class Bits
  constructor: (hex) ->
    @cursor = 0
    @bits = []
    byte = []
    for n in hex
      n = parseInt n, 16
      byte[b] = (n >> b) & 1 for b in [0...4]
      byte.reverse()
      Array::push.apply @bits, byte
  
  getNextValue: (maxValue) ->
    output = 0
    m = getBitsLength maxValue - 1
    for [0...m]
      output = output * 2 + @bits[@cursor]
      @cursor = ++@cursor % @bits.length
    if maxValue > 0 then output % maxValue else output
  
getBitsLength = (maxValue) ->
  if maxValue > 0 then 1 + Math.ceil Math.log(maxValue) / Math.LN2 else 0
 
maskHash = (bits, fragments) ->
  return null unless fragments instanceof Array
  return [] unless bits instanceof Bits
  output = []
  for fragment in fragments
    if fragment instanceof Array
      index = bits.getNextValue fragment.length - 1
      fragment = fragment[index]
      output.push index
      if fragment instanceof Array
        output.push maskHash bits, fragment
      else
        output.push bits.getNextValue fragment
    else
      output.push bits.getNextValue fragment
  output
 
splitHash = (hash, fragments) ->
  return [] unless typeof hash is "string" and /^[0-9a-f]+$/i.test hash
  bits = new Bits hash
  maskHash bits, fragments
  
if module?
  module.exports = splitHash
@.splitHash = splitHash