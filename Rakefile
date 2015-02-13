PATH_TO_GODOT = '/usr/local/bin/godot_x11-1.0stable.64'

task :default => :build_all

task :build_all do
  [ :build_android, :build_linux ].each do |t|
    Rake::Task[t].invoke
  end
end

task :build_android do
  sh "#{PATH_TO_GODOT} -export Android ./build/boatgame.apk"
end

task :build_linux do
  sh "#{PATH_TO_GODOT} -export 'Linux X11' ./build/boatgame-linux"
  sh 'chmod 0555 ./build/boatgame-linux'
end

