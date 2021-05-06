# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module ItemsHelper

  def boxes_available(item)
    Box.all.map {|box| box.boxname}.select {|x| x != item.box.boxname}
  end
end
