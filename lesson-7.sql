/* ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������. */

SELECT u.name 
FROM orders o
	JOIN users u ON u.id  = o.user_id
GROUP BY u.name
ORDER BY u.name;


/* �������� ������ ������� products � �������� catalogs, ������� ������������� ������.*/

SELECT p.id, p.name, p.price, c.name 
FROM products p
	JOIN catalogs c ON c.id = p.catalog_id
ORDER BY c.name, p.name;

/*����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name).
 ���� from, to � label �������� ���������� �������� �������, ���� name � �������. 
 �������� ������ ������ flights � �������� ���������� �������.*/

SELECT f.id, c.name, c2.name FROM flights f
	JOIN cities c ON c.label = f._from_
	JOIN cities c2 ON c2.label = f._to_
ORDER  BY f.id;