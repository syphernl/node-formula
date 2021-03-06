# NPM actions
{% for install_dir in salt['pillar.get']('node:npm:install_dirs', {}) %}
npm_install_{{ install_dir }}:
  cmd.run:
    - name: 'npm install'
    - cwd: {{ install_dir }}
    - unless: test -d {{ install_dir }}/node_modules
    {%- if install_user is defined %}
    - user: {{ install_user }}
    {%- endif %}
{% endfor %}

{%- for package in salt['pillar.get']('node:npm:install_pkgs', {}) %}
{{ package }}:
  npm.installed:
    - require:
      - pkg: nodejs
{%- endfor %}
