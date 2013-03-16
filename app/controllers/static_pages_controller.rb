require 'matrix'

class StaticPagesController < ApplicationController
  def home #in plain ruby, these methods would do nothing

    #@room = Room.new if signed_in?	#adding a room instance to the home action

    gon.xfinal = 1
    gon.yfinal = 1
    
    #OUTPUT:
    #12 x 12 boxes = 144 boxes
    #each box = 1 link
    #each box = 1 color
    #each box = 1 concept/context
    #box = {:link,:color,:context_name}

    #INPUT: a list of {:concept_name, :concept_rank, :urls}  :concept_rank - integer: 0 = best (single concept) ... branching -  up to 4 	concepts at rank 1, 16 at rank 2

    #each concept/context = many adjacent boxes, same color
    #color - distance from main concept/context
    #position - distance from main concept/context

    #data structure: 12 x 12 - each has concept_name
    
   	m = Matrix.build(7) {rand}
	urls = ["www.wikipedia.com","www.facebook.com","www.google.com","www.yahoo.com","www.tumblr.com","www.youtube.com","www.reddit.com"]
	context_names = ["apples","oranges","giraffes","music","games","pears","television"]

	#puts m
	r = m.row_size #Returns the number of rows.
	c = m.column_size

	@a = Array.new

	r.times.each do |row|
            @a[row] = {:concept => context_names[row], :size => 0, :urls => Array.new}

	    c.times.each do |column|
		if m[row,column] > 0.5
		    #claim this url(column) for this concept(row)
		    @a[row][:size] = @a[row][:size] + 1
                    @a[row][:urls][@a[row][:size]] = urls[column]
		end
	    end
	end

  end

  def help
  end

  def about
  end

  def contact
  end

  def convert_cartesian_to_index(x,y)
    index = (12*y) + x
    return index
  end

  def find_empty_position_spiral (a, x, y) 

    dir = 1 #1=down 2=up 3=left 4=right

    index = convert_cartesian_to_index(x,y)
    if index > 144 or index < 1 
        return nil
    end

    until y == 13 do
        index = convert_cartesian_to_index(x,y)
        if(a[index][:link] == "e") 
            return index
        end
        #(x,y) is taken
        if dir == 1 and y > x
            dir = 3 #turn left
        end
        if dir == 4 and x >= 12 - y
            dir = 1 #turn down
        end
        if dir == 2 and y <= x
            dir = 4
        end
        if dir == 3 and x < 12 - y
            dir = 2
        end

	if dir == 1
            y = y + 1
        end
        if dir == 2
            y = y - 1
        end
        if dir == 3
            x = x - 1
        end
        if dir == 4
            x = x + 1
        end               
    end
    index = convert_cartesian_to_index(x,y)
    return index
  end

  def find_empty_position_expanding_box(a,x,y)
    index = convert_cartesian_to_index(x,y)
    if index > 144 or index < 1 
        return nil
    end
    
    radius = 0
    until x == 1 or x == 12 or y == 1 or y == 12
      index = convert_cartesian_to_index(x,y)
      if(a[index][:link] == "e") 
        return index
      end
      #(x,y) is taken
    end
  end

  def convert_index_to_cartesian(i)
    y = i/12
    x = i%12
    return x,y
  end

  def rank_to_colour(rank)
    if rank == 1
        return '#FF3A3A'
    end
    if rank == 2
        return '#FF823A' #orange
    end
    if rank == 3
        return '#FFBE3A' #orange yellow
    end
    if rank == 4
        return '#FFE23A' #orange yellow
    end
    if rank == 5
        return '#D8FF3A' #lime
    end
    if rank == 6
        return '#99FF3A' #green
    end
    if rank == 7
        return '#54FF3A' #greener 54FF3A
    end
    if rank == 8
        return '#3AFFAA' #greener
    end
    if rank == 9
        return '#3AFFF9' #sky blue
    end
  end

end
