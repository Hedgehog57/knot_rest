#!/bin/bash
. /venv/bin/activate
if [ ! -f /var/lib/knot_rest/database.db ]; then
  flask --app 'knot_rest:create_app("/knot_rest.yaml")' database init && \
  flask --app 'knot_rest:create_app("/knot_rest.yaml")' users add ${KNOT_REST_ADMIN_USER} ${KNOT_REST_ADMIN_PASSWD} && \
  flask --app 'knot_rest:create_app("/knot_rest.yaml")' usermod admin add ${KNOT_REST_ADMIN_USER} 
fi

flask --app 'knot_rest:create_app("/knot_rest.yaml")' users reset ${KNOT_REST_ADMIN_USER} ${KNOT_REST_ADMIN_PASSWD}
python3 -m knot_rest -l knot_rest:$KNOT_REST_PORT -c /knot_rest.yaml
