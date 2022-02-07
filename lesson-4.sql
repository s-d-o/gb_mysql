/*�������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������*/
SELECT DISTINCT first_name FROM users
ORDER BY first_name;

/*�������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = false). 
 * �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = true (��� 1)*/

ALTER TABLE profiles ADD COLUMN is_active boolean DEFAULT true;

UPDATE profiles SET is_active = FALSE 
	WHERE birtday > date_add(now(),INTERVAL -18 year);

-- �������� ������, ��������� ��������� ��� �������� (���� ������ �����������)

DELETE FROM messages WHERE created_at > now()
