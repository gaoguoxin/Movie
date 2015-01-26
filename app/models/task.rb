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
  field :status,default:STATUS_UNDOING   #任务执行状态


  def self.get_site_task(website)
    task = self.where(site:website,status:STATUS_UNDOING).first
    task.update_attributes(:status:STATUS_DOING)
    return task 
  end

  def self.update_task(params)
  	task = self.where(site:params[:site],task_url:params[:url]).first
  	return false unless task.present?
  	if (!task.parent_url.present? && params[:childrn_url].present?)
    	params[:childrn_url].each do |url|
    		t = Task.where(task_url:url).first
    		Task.create(task_url:url,parent_url:params[:url],site:params[:site],title:task.title) unless t.present?
    	end 
  	end

  	unless task.parent_url.present?
  		film = Film.where(task_url:task.url).first
  		unless film.present?
  			Film.create(
  				title:task.title,task_url:task.url,
  				director:params[:basic_info][:director],
  				area:params[:basic_info][:area],
  				actors:params[:basic_info][:actors],
  				types:params[:basic_info][:types],
  				descript:params[:basic_info][:desc]
  			)
  		end
  	else
  		film = File.where(task_url:task.parent_url).first
  		return false unless film.present?
  		if params[:type].to_s == '1' # 正片
  		  film.basic_info["#{params[:site]}".to_sym][1] = {
  		  	url:task.url,
  		  	up_count:params[:up_count],
  		  	down_count:params[:down_count],
  		  	comment_count:params[:comment_count],
  		  	play_count:params[:play_count]
  		  }
  		else #预告或片花
  		  film.basic_info["#{params[:site]}".to_sym][0] << {
  		  	url:task.url,
  		  	up_count:params[:up_count],
  		  	down_count:params[:down_count],
  		  	comment_count:params[:comment_count],
  		  	play_count:params[:play_count]
  		  }  		  
  		end
  	end
  	return true
  end

end