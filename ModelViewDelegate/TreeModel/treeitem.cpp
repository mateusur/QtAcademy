#include "treeitem.h"

TreeItem::TreeItem(const QList<QVariant>& data,TreeItem* parent):
    m_itemData(data),m_parentItem(parent){}

TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *child)
{
    m_childItems.append(child);
}

TreeItem *TreeItem::child(int row)
{
    if(row < 0 || row >= m_childItems.size()){
        return nullptr;
    }
    return m_childItems.at(row);
}

int TreeItem::childCount() const
{
    return m_childItems.count();
}

int TreeItem::columnCount() const
{
    return m_itemData.count();
}

QVariant TreeItem::data(int column) const
{
    if(column < 0 || column >= m_itemData.size()){
        return QVariant();
    }
    return m_itemData.at(column);
}

void TreeItem::setData(int column, QVariant value)
{
    m_itemData.remove(column);
    m_itemData.insert(column,value);
}

int TreeItem::row() const
{
    if(m_parentItem){
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));
    }
    return 0;
}

TreeItem *TreeItem::parentItem()
{
    return m_parentItem;
}


