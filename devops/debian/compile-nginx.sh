#!/usr/bin/env bash
set -e

# Gather command line options.
for i in "$@"; do
    case $i in
        -skiptests|--skip-tests)  # Skip test portion of the build
            SKIPTESTS=YES
            ;;
        -d=*|--build-dir=*)  # Specify the directory to use for the build
            BUILDDIR="${i#*=}"
            shift
            ;;
        -skipinstall|--skip-install)  # Skip dpkg install
            SKIPINSTALL=YES
            ;;
	-httpsub|--http-substitutions-filter)
	    HTTPSUBSTITUTION=YES
	    ;;
        *)
            ;;
    esac
done

# Use the specified build directory, or create a unique temporary directory.
BUILDDIR=${BUILDDIR:-$(mktemp -d)}
echo "BUILD DIRECTORY USED: ${BUILDDIR}"
mkdir -p "${BUILDDIR}"
cd "${BUILDDIR}"

# Install curl
sudo apt update
sudo apt install curl -y
# Download the source tarball from Github
nginx_tarball_url="https://www.github.com$(curl 'https://github.com/nginx/nginx/releases' | grep -o "/nginx/nginx/archive/release-..*\.tar\.gz" | sort -r | head -1 | tr -d '\n')"
echo "DOWNLOADING FROM: ${nginx_tarball_url}"
curl -L --retry 5 "${nginx_tarball_url}" --output "nginx-source.tar.gz"
tar -zxf "nginx-source.tar.gz" --strip 1

# Download the http-substitutions-filter source tarball from Github
if [[ "${HTTPSUBSTITUTION}" == "YES" ]]; then
	ngx_http_substitutions_filter_tarball_url="https://www.github.com/yaoweibin$(curl 'https://github.com/yaoweibin/ngx_http_substitutions_filter_module/releases' | grep -o "/ngx_http_substitutions_filter_module/archive/v0..*\.tar\.gz" | sort -r | head -1 | tr -d '\n')"
	echo "DOWNLOADING NGX HTTP SUBSTITUTIONS FILTER FROM: ${ngx_http_substitutions_filter_tarball_url}"
	curl -L --retry 5 "${ngx_http_substitutions_filter_tarball_url}" --output "ngx-http-substitutions-filter-source.tar.gz"
	mkdir ngx_http_substitutions_filter_module
	tar -zxf "ngx-http-substitutions-filter-source.tar.gz" -C ./ngx_http_substitutions_filter_module --strip 1
fi

# Source dependencies
sudo apt install build-essential autoconf dh-autoreconf -y
# OpenSSL
sudo apt install libssl-dev -y
# Perl
sudo apt install libperl-dev -y
# Regular Expression
sudo apt install libpcre3 libpcre3-dev -y
# XSLT support
sudo apt install libxml2-dev libxslt1-dev -y
# Image Filter
sudo apt install libgd-dev -y
# GeoIP support
sudo apt install libgeoip-dev geoip-database -y


# Build it!
# --prefix=/usr/local
if [[ "${HTTPSUBSTITUTION}" == "YES" ]]; then
	auto/configure \
	    --prefix=/usr/local \
	    --modules-path=/usr/lib/nginx/modules \
	    --conf-path=/etc/nginx/nginx.conf \
	    --error-log-path=/var/log/nginx/error.log \
	    --http-log-path=/var/log/nginx/access.log \
	    --http-client-body-temp-path=/var/lib/nginx/body \
	    --http-proxy-temp-path=/var/lib/nginx/proxy \
	    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
	    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
	    --http-scgi-temp-path=/var/lib/nginx/scgi \
	    --pid-path=/run/nginx.pid \
	    --lock-path=/var/lock/nginx.lock \
	    --user=www-data \
	    --group=www-data \
	    --with-file-aio \
	    --with-http_ssl_module \
	    --with-http_v2_module \
	    --with-http_realip_module \
	    --with-stream_ssl_preread_module \
	    --with-stream_ssl_module \
	    --with-http_addition_module \
	    --with-http_xslt_module=dynamic \
	    --with-http_image_filter_module=dynamic \
	    --with-http_sub_module \
	    --with-http_dav_module \
	    --with-http_flv_module \
	    --with-http_mp4_module \
	    --with-http_geoip_module=dynamic \
	    --with-http_gunzip_module \
	    --with-http_gzip_static_module \
	    --with-http_random_index_module \
	    --with-http_secure_link_module \
	    --with-http_slice_module \
	    --with-http_stub_status_module \
	    --with-http_perl_module=dynamic \
	    --with-http_auth_request_module \
	    --with-mail=dynamic \
	    --with-mail_ssl_module \
	    --with-pcre \
	    --with-pcre-jit \
	    --with-stream=dynamic \
	    --with-threads \
	    --with-debug \
	    --with-cc-opt='-g -O2 -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic' \
	    --with-ld-opt='-Wl,-z,relro -Wl,-z,now -fPIC' \
	    --add-module=$BUILDDIR/ngx_http_substitutions_filter_module
else
	auto/configure \
	    --prefix=/usr/local \
	    --modules-path=/usr/lib/nginx/modules \
	    --conf-path=/etc/nginx/nginx.conf \
	    --error-log-path=/var/log/nginx/error.log \
	    --http-log-path=/var/log/nginx/access.log \
	    --http-client-body-temp-path=/var/lib/nginx/body \
	    --http-proxy-temp-path=/var/lib/nginx/proxy \
	    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
	    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
	    --http-scgi-temp-path=/var/lib/nginx/scgi \
	    --pid-path=/run/nginx.pid \
	    --lock-path=/var/lock/nginx.lock \
	    --user=www-data \
	    --group=www-data \
	    --with-file-aio \
	    --with-http_ssl_module \
	    --with-http_v2_module \
	    --with-http_realip_module \
	    --with-stream_ssl_preread_module \
	    --with-stream_ssl_module \
	    --with-http_addition_module \
	    --with-http_xslt_module=dynamic \
	    --with-http_image_filter_module=dynamic \
	    --with-http_sub_module \
	    --with-http_dav_module \
	    --with-http_flv_module \
	    --with-http_mp4_module \
	    --with-http_geoip_module=dynamic \
	    --with-http_gunzip_module \
	    --with-http_gzip_static_module \
	    --with-http_random_index_module \
	    --with-http_secure_link_module \
	    --with-http_slice_module \
	    --with-http_stub_status_module \
	    --with-http_perl_module=dynamic \
	    --with-http_auth_request_module \
	    --with-mail=dynamic \
	    --with-mail_ssl_module \
	    --with-pcre \
	    --with-pcre-jit \
	    --with-stream=dynamic \
	    --with-threads \
	    --with-debug \
	    --with-cc-opt='-g -O2 -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic' \
	    --with-ld-opt='-Wl,-z,relro -Wl,-z,now -fPIC'
fi
make

# Install
if [[ "${SKIPINSTALL}" != "YES" ]]; then
    # If you have an apt managed version of nginx, remove it.
    if sudo apt remove --purge nginx -y; then
        sudo apt-get autoremove -y
        sudo apt-get autoclean
    fi
    # Install the version we just built.
    sudo make install
    echo "Make sure to refresh your shell!"
    bash -c 'echo "$(which nginx) ($(nginx -v))"'
fi
