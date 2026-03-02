# -GalaxiEat-
TP SQL AVANCE

## Lancer et tester simplement

### 1) Créer/Recréer la base et exécuter tout le script

Depuis le dossier `GalaxiEat`:

```bash
sqlite3 galaxieat.db < galaxieat_tp.sql
```

Si `sqlite3` n'est pas installé sur ta machine, tu peux tester avec Python (module `sqlite3` intégré) :

```bash
/.venv/bin/python - <<'PY'
import sqlite3, pathlib
sql = pathlib.Path('galaxieat_tp.sql').read_text(encoding='utf-8')
conn = sqlite3.connect('galaxieat.db')
conn.executescript(sql)
conn.close()
print('Base créée avec succès: galaxieat.db')
PY
```

### 2) Ouvrir la base en mode lisible

```bash
sqlite3 galaxieat.db
```

Puis dans SQLite:

```sql
.mode column
.headers on
SELECT * FROM Restaurants;
SELECT dish_name, price FROM Dishes ORDER BY price;
SELECT * FROM CustomerOrders;
```

### 3) Repartir de zéro si besoin

Le script contient des `DROP TABLE IF EXISTS`, donc tu peux relancer la commande du point 1 autant de fois que nécessaire.
