module PermissionsConcern
  extend ActiveSupport::Concern
  def is_normal_capturista?
    self.role >=1
  end

  def is_jefecaptura?
    self.role >=2
  end

  def is_admin?
    self.role >=3
  end
end
