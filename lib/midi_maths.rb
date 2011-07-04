module MidiMaths

  def to_delta(dec_num)
    bin_num=dec_num.to_s(2)
    time=bin_to_midihex(bin_num)
  end

  def bin_to_midihex(bin_num)
    bytes=Array.new
    bin_array=bin_num.reverse.split(//)
    count=0
    until bin_array.length==0 do
      count+=1
      byte=""
      bin_array.slice!(0,7).each{|bit| byte<<bit}
      byte.reverse!
      if count==1
        bytes<<byte.rjust(8,"0")
      elsif bin_array.length==0      
        byte=byte.rjust(7,"0")
        bytes<<"1"+byte
      else
        bytes<<"1"+byte
      end
    end
    bytes.reverse!
    hex_string=""
    bytes.each do |byte|
      hex_byte=byte.to_i(2).to_s(16)
      hex_byte=="0" && hex_byte+="0"
      hex_string<<hex_byte        
    end
    hex_string
  end

  def add_zero(hex_num)
    if hex_num.length==1
      hex_num="0"+hex_num
    else
      hex_num
    end
  end

  
  def get_fifth(tone)
    pos=ALL_NOTES.index(tone)
    fifth_pos=(pos+7)%12
    fifth=ALL_NOTES[fifth_pos]
  end


end

