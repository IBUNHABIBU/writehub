[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]



<p align="center">
  <a href="git@github.com:IBUNHABIBU/platform-game.git">
    <p align="center"> <img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/rails/rails.png" alt="Ruby on rails" width="100" height="100"> </p>
  </a>

  <h2 align="center">  Lifestyle articles</h2>
  <h3 align="center"> Building a Rails website to post lifestyle articles </h3>

  <p align="center">
    <a href="https://github.com/IBUNHABIBU/lifestyle_articles/issues">Report Bug</a>
    <a href="https://github.com/IBUNHABIBU/lifestyle_articles/issues">Request Feature</a>
  </p>
</p>

This is the Capstone project. It is done after completion of
Microverse Main technical curriculum section. 
Building this project is very important  because:

* It's a real-world-like project, built with business specifications 
* that will look  nice in your portfolio and
* You will get feedback about the achievement of technical and soft 
  skills gained during this section of the program.

![screenshot](https://github.com/IBUNHABIBU/deployblog/blob/dev/app/assets/images/Homepage.png)
![screenshot](https://github.com/IBUNHABIBU/deployblog/blob/dev/app/assets/images/catshow.png)
![screenshot](https://github.com/IBUNHABIBU/deployblog/blob/dev/app/assets/images/newarticle.png)

## Built with 
* Ruby on Rails
* Bootstrap
* RSpec 

## Features 
  * Users 
    * Signup/login/logout its simple only username is required 
    * Create categories
    * Create articles with images
    * have many articles 
  * Articles 
     * Belongs to user
     * Have many and belongs categories
     * Have many likes 
     * The most voted articles is the first to be displayed with big picture in home page  
     * Other articles are displayed with their background images in order of most recent.
 * Categories 
    * Have many and belongs to articles 
    * All categories are displayed in navbar according to their priority
  * Likes 
    * Belongs to user
    * Belongs to article

## Next version 
  * mobile responsive
  * admin requirement
  * same user is able to delete his own article

## Requirement 
* Ruby '~>3.1.0'
* Rails '~>7.0.3' 
* PostgreSQL 9.2.24

## Usage
Clone this repository and run the following commands \
 `$bundle install --without-production` 
 
 `$sudo service postgresql start` 
 
 `$rails db:migrate` 
 
 `$rails s ` 
 
then open http://localhost:3000/

## Run tests
Navigate to the project folder make sure Rspec is installed and then run the following command 

`$rspec -f d` 

## [Live demo](https://darlive.onrender.com "Of the project") of the project

## link to  [Video presentation](https://www.loom.com/share/ee056e3f2c984839a9c8a463381c46e5 "Loom")

# Entity Relationship Diagram (ERD)

![screenshot](https://github.com/IBUNHABIBU/deployblog/blob/dev/app/assets/images/ERD__articles.png)

## Useful Commands

| Command | Description |
|---------|-------------|
| `rails new . --css=sass --javascript=esbuild --database=postgresql` | create new project inside current directory |
| `bundle install` | Install project dependencies |
| `sudo service postgresql start` | Starting the database |
| `rails db:migrate` | Database migration |
| `rails server` | start the server |
| `rubocop -a` | Fix all the lint errors automatically |
| `bundle exec rspec` | Run rspec tests |
| `rspec spec/requests --format documentation` |	Run all rspec tests well formated
| `rspec spec/requests --format doc` |	Run all rspec tests well formated
| `rspec spec/requests -f d` |	Run all rspec tests well formated
| `EDITOR='code --wait' rails credentials:edit` | Edit credentials |
| `rails routes | grep users` | check routes of the specific resource |

## Author
* Github: [IBUNHABIBU](https://github.com/IBUNHABIBU)
* Twitter: [@ibunhabibu](https://twitter.com/Ibunhabibu)
* LinkedIn: [Salum Habibu Kombo](https://www.linkedin.com/in/salum-habibu/)

## your support 
Give a :star: if you liked this project 
## Acknowledgments
Credits go to

- [Nelson Sakwa](https://www.behance.net/gallery/14554909/liFEsTlye-Mobile-version) who designed this template on [behance.net](https://www.behance.net/gallery/14554909/liFEsTlye-Mobile-version)
- My mentor Raphael Noriode for technical assistance
- All Microverse TSEs for their feedback that make me to improve technically

# Challenges I faced
 -Edit the credentials
   EDITOR=vim rails credentials:edit
   sudo apt-get install vim
  
  rbenv: version `ruby-2.6.3' is not installed
  `solution: rbenv install 2.6.3`

  `undefined method 'signed_id' for nil:NilClass`
  this is caused by no record in the active storage
  solution: rails db:reset 

  State changed from starting to crashed
  error code=H10
  The above error was caused by typing error of variables
  instead of :amazon I typed :amazone in production.rb file

  web: rake db:migrate && bin/rails server -b 0.0.0.0 -p { PORT: -3000 } && bin/rails css:watch
## 📝 License
This project is [MIT](LICENCE) licensed.

[contributors-shield]: https://img.shields.io/github/contributors/IBUNHABIBU/lifestyle_articles.svg?style=flat-square
[contributors-url]: https://github.com/IBUNHABIBU/lifestyle_articles/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/IBUNHABIBU/lifestyle_articles.svg?style=flat-square
[forks-url]: https://github.com/IBUNHABIBU/lifestyle_articles/network/members
[stars-shield]: https://img.shields.io/github/stars/IBUNHABIBU/lifestyle_articles.svg?style=flat-square
[stars-url]: https://github.com/IBUNHABIBU/lifestyle_articles/stargazers
[issues-shield]: https://img.shields.io/github/issues/IBUNHABIBU/lifestyle_articles.svg?style=flat-square
[issues-url]: https://github.com/IBUNHABIBU/lifestyle_articles/issues



## Configuration
1. Passenger 
    - Open passenger config file
       `sudo nano /etc/nginx/conf.d/mod-http-passenger.conf`
    - Add the following lines
        `passenger_ruby /home/deploy/.rbenv/shims/ruby;`
    - Restart nginx
        `sudo service nginx restart`

2. Nginx
    - Open nginx config file 
         `sudo nano /etc/nginx/sites-enabled/linodeblog`
    - Add the following lines
```
      server {
      listen 80;
      listen [::]:80;

      server_name domainname.com www.domainname.com;
      root /home/deployer/linodeblog/current/public;

        passenger_enabled on;
        passenger_app_env production;

        location /cable {
          passenger_app_group_name linodeblog_websocket;
          passenger_force_max_concurrent_requests_per_process 0;
        }

        # Allow uploads up to 100MB in size
        client_max_body_size 100m;

        location ~ ^/(assets|packs) {
          expires max;
          gzip_static on;
        }
      }
```
    - Restart nginx
        `sudo service nginx restart`

3. Database
     - create project directory
        `mkdir /home/deployer/linodeblog`
      - Add the environment variables
        `nano /home/deployer/linodeblog/.rbenv-vars`

        Add the following 
```        
DATABASE_URL=postgresql://postgres:fancypswd@127.0.0.1/myapp



```
       - See list of users
        `sudo -u postgres psql`
         `postgres=# \du`

        - Create database
          `sudo su - postgres`
          `createdb -O postgres linodeblog`

        - See list of databases
          `postgres=# \l`

        - Connect to database
          `sudo -u postgres psql linodeblog`
          `linodeblog=# \dt`
        
        exit the database and type the below command
          `psql -U postgres -W -h 127.0.0.1 -d linodeblog_production` 

4. Installing ssl certificate
    follow this [link] (https://gorails.com/guides/free-ssl-with-rails-and-nginx-using-let-s-encrypt)

    and then 
 `sudo certbot --nginx -d car.darlive.cyou -d www.car.darlive.cyou`

5. Logs 
    # To view the Rails logs
    `less /home/deployer/linodeblog/current/log/production.log`
    `sudo tail -f /home/deployer/linodeblog/current/log/production.log`

    # To view the NGINX and Passenger logs
    `sudo less /var/log/nginx/error.log` then type shift + G to go down to the very bottom of the error logs

    # To view logs of the app
    `sudo tail -f /var/log/syslog`

    # to see production logs in Linux
     `sudo tail -f /var/log/nginx/access.log`

    #to view rails log
    `sudo tail -f /var/log/syslog | grep rails less /home/deployer/carlinode/current/log/production.log`


2. **Start a `screen` Session**: Start a new `screen` session by typing:

    ```
    screen -S linodeblog
    ```

3. **Start Your Rails Server**:

    ```
    sudo service nginx restart
    ```

   This command will restart Nginx, and it should pick up your linode Rails application through Passenger.

4. **Detach from the `screen` Session**: To detach from the `screen` session without stopping your Rails server (which is managed by Nginx and Passenger), press `Ctrl+a` followed by `d`. You'll return to your regular shell.

5. **Close your SSH session**: Now you can safely close your SSH session, and your Nginx server with Passenger should continue to serve your linode Rails application.

6. **Reattach to the `screen` Session (Optional)**: If you need to reattach to your `screen` session later to check logs or manage your application, SSH back into your server and run:

    ```
    screen -r linode
    ```


By using `screen`, you can keep your session running and access it later if needed, although typically with Nginx and Passenger, you won't need to interact with your Rails server directly once it's configured and running properly.

To filter docker errors 

`docker logs --since 1h <CONTAINER_ID> 2>&1 | grep "ERROR"`

Global filtering for all containers 

`docker ps -q | xargs -n 1 docker logs --since 1h 2>&1 | grep "ERROR"`


Monitoring logs in real time
`docker logs -f <CONTAINER_ID> 2>&1 | grep "ERROR"`

Advanced Error filtering 

`docker logs --since 1h <CONTAINER_ID> 2>&1 | grep -E "ERROR|WARN|FATAL|CRITICAL"`

I have successfully deployed the Rails 8 app using Kamal 2.3.0 on a Contabo VPS. However, I am encountering a permission issue when uploading a file to the live app running in a Docker container in production. The error I am receiving is:- 

    `[e89790a9-23c2-4327-9d9e-d772c0d78310] Errno::EACCES (Permission denied @ dir_s_mkdir - /rails/storage/xf)`


deployer@vmi1909189:~$ docker exec -it -u 0 86417933f9c9 chmod -R 777 /rails/storage





#### wanga