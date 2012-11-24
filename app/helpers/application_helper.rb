# encoding: utf-8
module ApplicationHelper

  #自定义辅助方法　将英文题目类型转为中文题目类型
  def typies_tochinese(typies)
    ch_typies = ""
    if typies == "single"
      ch_typies ="单选题"
    elsif typies == "much"
      ch_typies = "多选题"
    elsif typies == "judge"
      ch_typies = "判断题"
    end
    ch_typies
  end

  #统计所有的行业分类
  def all_header_categories
    Category.find(:all, :conditions => ["super = 1"])
  end
  def sub_categories(header)
    Category.find(:all, :conditions => ["super = ?", header])
  end

  #自定义辅助方法　统计用户分类下的题库量
  def count_user_category(category)
    Storage.find(:all, :conditions => "category_id = " + category.to_s ).length
  end

  def format_datetime(fdt)
    unless fdt.nil?
      if fdt.year == Time.now.year
        return fdt.strftime("%m月%d日 %H点%M分")
      else
        return fdt.strftime("%Y年%m月%d日 %H点%M分")
      end
    else
      return ""
    end
  end

def img_logo
  image_tag("app/logo.png")
end
def img_class_c
  image_tag("app/Category.png", :size => "40x40")
end
def img_arrow
  image_tag("app/arrow.png")
end

def img_storage(typies)
  case typies
  when "single"
    return image_tag("app/single.png")
  when "much"
    return image_tag("app/much.png")
  when "judge"
    return image_tag("app/judge.png")
  end
end

def img_rule(time)
  if time > Time.now
    return image_tag("app/rule_effective.png")
  else
    return image_tag("app/rule_over.png")
  end
end

def img_option(option)

  case option
  when "A"
    return image_tag("app/optiona.png")
  when "B"
    return image_tag("app/optionb.png")
  when "C"
    return image_tag("app/optionc.png")
  when "D"
    return image_tag("app/optiond.png")
  when "E"
    return image_tag("app/optione.png")
  when "F"
    return image_tag("app/optionf.png")
  when "G"
    return image_tag("app/optiong.png")
  when "H"
    return image_tag("app/optionh.png")
  when "I"
    return image_tag("app/optioni.png")
  when "J"
    return image_tag("app/optionj.png")
  end
end



end
