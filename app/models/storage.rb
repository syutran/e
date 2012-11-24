class Storage < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_category, :foreign_key => :category_id
  before_save :setup_default
  validates :title, :presence=>{:message => "err"}
  def akey
    v = ""
    unless self.key.blank?
      if self.key.include??A
        v = "A"
      end
    end
    v
  end
  def akey=(v)
    if v == "A"
      if self.key.blank?
        self.key = "A"
      else
        unless self.key.include??A
          self.key += "A"
        end
      end
    end
  end
  def bkey
    v = ""
    unless self.key.blank?
      if self.key.include??B
        v = "B"
      end
    end
    v
  end
  def bkey=(v)
    if v == "B"
      if self.key.blank?
        self.key = "B"
      else
        unless self.key.include??B
          self.key += "B"
        end
      end
    end
  end
  def ckey
    v = ""
    unless self.key.blank?
      if self.key.include??C
        v = "C"
      end
    end
    v
  end
  def ckey=(v)
    if v == "C"
      if self.key.blank?
        self.key = "C"
      else
        unless self.key.include??C
          self.key += "C"
        end
      end
    end
  end
  def dkey
    v = ""
    unless self.key.blank?
      if self.key.include??D
        v = "D"
      end
    end
    v
  end
  def dkey=(v)
    if v == "D"
      if self.key.blank?
        self.key = "D"
      else
        unless self.key.include??D
          self.key += "D"
        end
      end
    end
  end
    def ekey
    v = ""
    unless self.key.blank?
      if self.key.include??E
        v = "E"
      end
    end
    v
  end
  def ekey=(v)
    if v == "E"
      if self.key.blank?
        self.key = "E"
      else
        unless self.key.include??E
          self.key += "E"
        end
      end
    end
  end
    def fkey
    v = ""
    unless self.key.blank?
      if self.key.include??F
        v = "F"
      end
    end
    v
  end
  def fkey=(v)
    if v == "F"
      if self.key.blank?
        self.key = "F"
      else
        unless self.key.include??F
          self.key += "F"
        end
      end
    end
  end
    def gkey
    v = ""
    unless self.key.blank?
      if self.key.include??G
        v = "G"
      end
    end
    v
  end
  def gkey=(v)
    if v == "G"
      if self.key.blank?
        self.key = "G"
      else
        unless self.key.include??G
          self.key += "G"
        end
      end
    end
  end
    def hkey
    v = ""
    unless self.key.blank?
      if self.key.include??H
        v = "H"
      end
    end
    v
  end
  def hkey=(v)
    if v == "H"
      if self.key.blank?
        self.key = "H"
      else
        unless self.key.include??H
          self.key += "H"
        end
      end
    end
  end
    def ikey
    v = ""
    unless self.key.blank?
      if self.key.include??I
        v = "I"
      end
    end
    v
  end
  def ikey=(v)
    if v == "I"
      if self.key.blank?
        self.key = "I"
      else
        unless self.key.include??I
          self.key += "I"
        end
      end
    end
  end
    def jkey
    v = ""
    unless self.key.blank?
      if self.key.include??J
        v = "J"
      end
    end
    v
  end
  def jkey=(v)
    if v == "J"
      if self.key.blank?
        self.key = "J"
      else
        unless self.key.include??J
          self.key += "J"
        end
      end
    end
  end

  protected

  def setup_default
    if self.title then string_total = self.title.length end
    if self.itema then string_total += self.itema.length end
    if self.itemb then string_total += self.itemb.length end
    if self.itemc then string_total += self.itemc.length end
    if self.iteme then string_total += self.iteme.length end
    if self.itemf then string_total += self.itemf.length end
    if self.itemg then string_total += self.itemg.length end
    if self.itemh then string_total += self.itemh.length end
    if self.itemi then string_total += self.itemi.length end
    if self.itemj then string_total += self.itemj.length end
    if string_total/5 < 3 then self.needtime = 3 else self.needtime = string_total/self.speed end
  end
  
end
