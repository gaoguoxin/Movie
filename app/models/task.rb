class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS_UNDOING    = 0 #尚未执行
  STATUS_DOING      = 1 #正在执行
  STATUS_COMPLETED  = 2 #已完成


  field :title #电影名称
  field :site  #网站名称
  field :task_url #任务链接地址
  field :parent_url #衍生出的链接地址
  field :status,default:STATUS_UNDOING,default:STATUS_UNDOING   #任务执行状态

  def self.avalible_site
    return [['土豆网','tudou'],['优酷网','youku'],['腾讯网','tecent'],['爱奇艺','iqiyi']]
  end

  def self.get_site_task(website)
    task = self.where(site:website,status:STATUS_UNDOING).first
    task.update_attributes(status:STATUS_DOING)
    return task 
  end

  def self.update_task(params)
    params = JSON.parse(params)
    Rails.logger.info('-----------------------------------------------')
    Rails.logger.info(params)
    Rails.logger.info('-----------------------------------------------')         
  	task = self.where(site:params["from"],task_url:params["url"]).first
    task = self.where(site:params["from"],task_url:params["ref_url"]).first unless task.present?
    Rails.logger.info('===============================================')
    Rails.logger.info(task.inspect)
    Rails.logger.info('===============================================')
  	return false unless task.present?
  	if (!task.parent_url.present? && params["child_url"].present?)
        Rails.logger.info('111111111111111111111111111')
    	params["child_url"].each do |url|
    		t = Task.where(task_url:url).first
    		Task.create(task_url:url,parent_url:task.task_url,site:params["from"],title:task.title) unless t.present?
    	end 
  	end

  	unless task.parent_url.present?
      Rails.logger.info('2222222222222222222222222')
  		film = Film.where(title:task.title).first
  		unless film.present?
  			Film.create(
  				title:task.title,
  				director:params["basic_info"]["director"],
  				area:params["basic_info"]["area"],
  				actors:params["basic_info"]["actors"],
  				types:params["basic_info"]["types"],
  				descript:params["basic_info"]["desc"]
  			)
  		end
  		task.update_attributes(status:STATUS_COMPLETED)
  	else
      Rails.logger.info('33333333333333333333333333333333')
  		film = Film.where(title:task.title).first
      Rails.logger.info('-------------------dddddddddddddd------------------')
      Rails.logger.info(film.inspect)
      Rails.logger.info('-------------------dddddddddddddd------------------')
  		return false unless film.present?
  		if params["type"].to_s == '1' # 正片
          Rails.logger.info('444444444444444444444444444444')
  		  film.basic_info["#{params['site']}".to_sym][1] = {
  		  	url:task.url,
  		  	up_count:params["up_count"],
  		  	down_count:params["down_count"],
  		  	comment_count:params["comment_count"],
  		  	play_count:params["play_count"]
  		  }
  		else #预告或片花
        Rails.logger.info('5555555555555555555555555555')
  		  film.basic_info["#{params['site']}".to_sym][0] << {
  		  	url:task.url,
  		  	up_count:params["up_count"],
  		  	down_count:params["down_count"],
  		  	comment_count:params["comment_count"],
  		  	play_count:params["play_count"]
  		  }  		  
  		end
  		task.update_attributes(status:STATUS_COMPLETED)
  	end
  	return true
  end

end
