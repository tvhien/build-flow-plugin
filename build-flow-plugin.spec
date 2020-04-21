%global     plugin_name build-flow-plugin
Name:       jenkins-in-house-plugins-%{plugin_name}
Version:    0.20
Release:    1%{?dist}
Summary:    A jenkins in-house plugins %{plugin_name}.hpi
Requires:   jenkins
Group:      Development/Libraries
License:    BSD
URL:        https://github.com/gooddata/%{plugin_name}
Source0:    %{name}.tar.gz

BuildRequires: java
BuildRequires: maven

%description
Packaged jenkins-in-house-plugin-%{plugin_name} %{plugin_name}.hpi file

%prep
%setup -n %{name} -c 

%build
mvn versions:set -DnewVersion=%{version}
mvn versions:commit
mvn package --batch-mode -Dmaven.test.skip=true
# temporary skip test for now until we done refactor unit test for this rpm

%install
%{__mkdir_p} %{buildroot}%{_sharedstatedir}/juseppe
%{__cp} target/%{plugin_name}.hpi %{buildroot}%{_sharedstatedir}/juseppe/

%files
%defattr(-,root,root,-)
%dir %{_sharedstatedir}/juseppe
%{_sharedstatedir}/juseppe/%{plugin_name}.hpi

%changelog
* Mon Apr 13 2020 +0700 tvhien <tranvanhien.engineer@gmail.com> - 0.20-1
- CONFIG: SETI-4077 add build-flow-plugin.spec and Makefile
