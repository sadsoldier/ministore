
AUTOMAKE_OPTIONS = foreign no-dependencies no-installinfo

APPDIR = app

build:
#	cd app && bundle config build.nokogiri '--use-system-libraries'
#	cd app && bundle config build.sassc '--disable-march-tune-native --disable-lto'
#	cd app && bundle config build.sassc '--disable-lto'
#	cd app && bundle install --path vendor/bundle --clean
#	cd app && yarn install
#	cd app && bundle exec rake assets:precompile
#	mkdir -p app/run app/tmp app/log
	cd app && bundle install
	cd app && yarn install
	cd app && RAILS_ENV=production bundle exec rake assets:clean
	cd app && RAILS_ENV=production bundle exec rake assets:precompile


bin_SCRIPTS = ministore

EXTRA_DIST = app

install-data-local:
	test -z $(DESTDIR)$(APP_LIBDIR) || $(MKDIR_P) $(DESTDIR)$(APP_LIBDIR)
	cd ${APPDIR} && cp -r . $(DESTDIR)$(APP_LIBDIR)
	test -z $(DESTDIR)$(APP_LOGDIR) || $(MKDIR_P) $(DESTDIR)$(APP_LOGDIR)
	test -z $(DESTDIR)$(APP_RUNDIR) || $(MKDIR_P) $(DESTDIR)$(APP_RUNDIR)
	test -z $(DESTDIR)$(APP_CACHEDIR) || $(MKDIR_P) $(DESTDIR)$(APP_CACHEDIR)
	test -z $(DESTDIR)$(APP_DATABASEDIR) || $(MKDIR_P) $(DESTDIR)$(APP_DATABASEDIR)
#EOF
