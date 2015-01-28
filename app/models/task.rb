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
    task.update_attributes(status:STATUS_DOING) if task.present?
    return task 
  end

  def self.update_task(params)
    params = JSON.parse(params)       
  	task = self.where(site:params["from"],task_url:params["url"]).first
    task = self.where(site:params["from"],task_url:params["ref_url"]).first unless task.present?
  	return false unless task.present?
  	if (!task.parent_url.present? && params["child_url"].present?)
      Rails.logger.info('------------基本信息收录中。。。。。-----------------')
    	params["child_url"].each do |url|
    		t = Task.where(task_url:url).first
    		Task.create(task_url:url,parent_url:task.task_url,site:params["from"],title:task.title) unless t.present?
    	end 
  	end

  	unless task.parent_url.present?
  		film = Film.where(title:task.title).first
  		unless film.present?
        Rails.logger.info('----------------创建电影中。。。。。-------------------------')
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
  		film = Film.where(title:task.title).first
  		return false unless film.present?
  		if params["type"].to_s == '1' # 正片
        Rails.logger.info('--------------正片信息收录中。。。。。--------------')
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')
        Rails.logger.info(film.basic_info["#{params['from']}"])
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')
        Rails.logger.info(film.basic_info["#{params['from']}".to_sym])
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')        
  		  film.basic_info["#{params['from']}".to_sym][1] = {
  		  	url:params["url"],
  		  	up_count:params["up_count"],
  		  	down_count:params["down_count"],
  		  	comment_count:params["comment_count"],
  		  	play_count:params["play_count"]
  		  }
  		else #预告或片花
        Rails.logger.info('--------------预告信息收录中。。。。---------------')
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')
        Rails.logger.info(film.basic_info["#{params['from']}"])
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')
        Rails.logger.info(film.basic_info["#{params['from']}".to_sym])
        Rails.logger.info('ddddddddddddddddddddddddddddddddddddddddddddddddd')
  		  film.basic_info["#{params['from']}".to_sym][0] << {
  		  	url:params["url"],
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
